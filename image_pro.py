#!/usr/bin/python3
from PIL import Image
import requests
from io import BytesIO
import sys
import cv2


thresh = 130
limit_ilum = 70
limit_foc = 200
baseWidth = 50
illum = []
foc = []
link = sys.argv[1]


def illumination(img):
    relation = (baseWidth/float(img.size[0]))
    baseHeigth = int((float(img.size[1])*float(relation)))
    resizedImage = img.resize((baseWidth, baseHeigth))
    color = resizedImage.convert('L').point(lambda x:
                                            255 if x > thresh else 0, '1')
    pixs = color.getdata()
    pixs = [sets for sets in pixs]
    illum.append(sum(pixs)/len(pixs) > limit_ilum)


def focus():
    image = cv2.imread('./img.jpg')
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    focus = cv2.Laplacian(gray, cv2.CV_64F).var()
    foc.append(focus > limit_foc)


with open('img.jpg', 'wb') as f:
    f.write(requests.get(link).content)
with Image.open('./img.jpg') as img:
    illumination(img)
    focus()
print(illum[0], foc[0])
