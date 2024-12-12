import os
import sys
import io
from PIL import Image, ImageFilter
import cv2
import numpy as np
from rembg import remove
class ProcessImage:
    def __init__(self, image_path, output_dir, operation, file_format):
        self.image = Image.open(image_path)
        self.output_dir = output_dir
        self.operation = operation
        self.file_format = file_format

    def process(self):
        if self.operation == 'cut':
          self.cut()
        elif self.operation == 'add_shadows':
          self.add_shadows()
        elif self.operation == 'blure_plates':
          self.blure_plates()
        elif self.operation == 'tint_windows':
          self.tint_windows()
        if not os.path.exists(self.output_dir):
            os.makedirs(self.output_dir)
        if self.file_format.upper() == 'JPEG' and self.image.mode == 'RGBA':
          self.image = self.image.convert('RGB')
        output_path = f'{self.output_dir}/{self.operation}.{self.file_format.lower()}'
        self.image.save(output_path, format=self.file_format)
        print(output_path)

    def cut(self):
        input_image = self.image.convert('RGBA')
        img_byte_arr = io.BytesIO()
        input_image.save(img_byte_arr, format='PNG')
        img_byte_arr = img_byte_arr.getvalue()

        output_data = remove(img_byte_arr)
        output_image = Image.open(io.BytesIO(output_data))
        self.image = output_image

    def add_shadows(self):
        # Преобразуем изображение в формат OpenCV для дальнейшей обработки
        img_cv = np.array(self.image.convert('RGBA'))
        # Преобразуем в серый цвет, чтобы найти контуры
        gray = cv2.cvtColor(img_cv, cv2.COLOR_RGBA2GRAY)
        _, thresholded = cv2.threshold(gray, 1, 255, cv2.THRESH_BINARY)

        # Находим контуры автомобиля
        contours, _ = cv2.findContours(thresholded, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        # Создаем маску для тени, которая будет соответствовать контуру
        shadow_mask = np.zeros_like(gray)
        cv2.drawContours(shadow_mask, contours, -1, (255), thickness=cv2.FILLED)

        # Преобразуем маску в изображение
        shadow_mask_pil = Image.fromarray(shadow_mask)

        # Создаем полностью красное изображение с прозрачностью
        shadow = Image.new('RGBA', self.image.size, (20, 20, 20, 128))  # Красный цвет с прозрачностью

        # Применяем размытие для тени
        blurred_shadow = shadow_mask_pil.filter(ImageFilter.GaussianBlur(20))  # Увеличиваем размытие для мягкости

        # Создаём маску тени для добавления прозрачности
        shadow_with_alpha = Image.new('RGB', self.image.size, (0, 0, 0, 0))
        shadow_with_alpha.paste((20, 20, 20, 128), mask=blurred_shadow)  # Полупрозрачная красная тень

        # Смещаем тень для создания эффекта
        shadow_offset = Image.new('RGBA', self.image.size, (0, 0, 0, 0))
        shadow_offset.paste(shadow_with_alpha, (15, 35), mask=blurred_shadow)

        # Наложение тени на изображение с сохранением прозрачности
        image_with_shadow = Image.alpha_composite(shadow_offset, self.image.convert('RGBA'))

        # Преобразуем в RGB, чтобы избавиться от прозрачности
        self.image = image_with_shadow.convert('RGBA')
    def blure_plates(self):
        img_cv = np.array(self.image)
        gray = cv2.cvtColor(img_cv, cv2.COLOR_BGR2GRAY)
        classifier = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_russian_plate_number.xml')
        plates = classifier.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))
        for (x, y, w, h) in plates:
            roi = img_cv[y:y+h, x:x+w]
            roi_blurred = cv2.GaussianBlur(roi, (75, 75), 0)
            img_cv[y:y+h, x:x+w] = roi_blurred
        self.image = Image.fromarray(img_cv)

    def tint_windows(self):
               # Преобразуем изображение в формат OpenCV (BGR)
        img_cv = np.array(self.image)
        img_cv = cv2.cvtColor(img_cv, cv2.COLOR_RGB2BGR)

        # Преобразуем в серое изображение для поиска контуров
        gray = cv2.cvtColor(img_cv, cv2.COLOR_BGR2GRAY)

        # Применяем Canny для выделения краёв
        edges = cv2.Canny(gray, 50, 150)

        # Увеличиваем края с помощью dilation
        kernel = np.ones((5, 5), np.uint8)
        dilated = cv2.dilate(edges, kernel, iterations=2)

        # Находим контуры
        contours, _ = cv2.findContours(dilated, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        # Список для хранения координат найденных окон
        windows = []

        # Процесс поиска окон
        for contour in contours:
            if cv2.contourArea(contour) > 500:  # Фильтруем маленькие контуры
                x, y, w, h = cv2.boundingRect(contour)

                # Проверяем, является ли найденный контур окном
                if self.is_window(x, y, w, h):
                    windows.append((x, y, w, h))

        # Затемняем только окна
        for (x, y, w, h) in windows:
            img_cv = self.darken_area(img_cv, x, y, w, h)

        # Преобразуем обратно в PIL изображение
        self.image = Image.fromarray(cv2.cvtColor(img_cv, cv2.COLOR_BGR2RGB))

    def is_window(self, x, y, w, h):
        # Проверяем, является ли прямоугольник окном (считаем, что окна имеют пропорцию сторон от 1.5 до 3.5)
        aspect_ratio = w / h
        if 1.5 < aspect_ratio < 3.5:  # Соотношение сторон для окон
            return True
        return False

    def darken_area(self, img_cv, x, y, w, h):
        # Наложение затемнённой маски на найденную область (окно)
        overlay = img_cv[y:y+h, x:x+w]
        overlay = cv2.addWeighted(overlay, 0.5, np.zeros_like(overlay), 0, 0)  # Затемнение

        # Наложение затемнённого окна обратно на изображение
        img_cv[y:y+h, x:x+w] = overlay
        return img_cv

if __name__ == '__main__':
    image_path = sys.argv[1]
    output_dir = sys.argv[2]
    operation = sys.argv[3]
    file_format = sys.argv[4]
    processor = ProcessImage(image_path, output_dir, operation, file_format)
    processor.process()
