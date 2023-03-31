import sys
from typing import List
import zipfile
import os
import pandas as pd
import chardet  # 패키지 설치 필요
import openpyxl  # 패키지 설치 필요


def is_compressed_file(file_path):
    """
    파일이 압축 파일인지 아닌지 판단하는 함수
    :param file_path: 파일 경로
    :return: 압축 파일이면 True, 아니면 False
    """
    if 'zip' in file_path:
        return True


# file_path -> Encoding Type
def is_encoded(file_path: str):
    rawdata = open(file_path, mode='rb').read()
    data = chardet.detect(rawdata)
    result = data['encoding']
    return result


# File_path, Encoding_Type -> Change Files encoding type
def to_ansi(file_path: str, encoding_in: str):
    try:
        with open(file_path, 'r', encoding=encoding_in) as f:
            datas = f.read()

        with open(file_path, 'w', encoding='ansi') as k:
            k.write(datas)
    except:
        print('변환 실패')


def is_csv_file(file_path):
    """
    파일이 CSV 파일인지 아닌지 판단하는 함수
    :param file_path: 파일 경로
    :return: CSV 파일이면 True, 아니면 False
    """
    _, ext = os.path.splitext(file_path)
    return ext.lower() == '.csv'


def unzip_file(file_path, dest_path=None) -> list[str]:
    """
    ZIP 파일을 해제하고, 각 파일의 이름을 출력하는 함수
    :param file_path: ZIP 파일 경로
    :param dest_path: 해제할 디렉토리 경로 (기본값은 ZIP 파일과 같은 경로)
    """
    # ZIP 파일 열기
    with zipfile.ZipFile(file_path, 'r') as zip_ref:
        # 해제할 디렉토리 경로 지정
        if dest_path is None:
            dest_path = os.path.dirname(file_path)
        # ZIP 파일 해제
        zip_ref.extractall(dest_path)

        # 각 파일의 이름 출력
        file_list = []
        for file_info in zip_ref.infolist():
            file_list.append(os.path.join(dest_path, file_info.filename))
        return file_list


def csv_to_excel(file_path: str):
    encoding = is_encoded(file_path)
    data = pd.read_csv(file_path, encoding=encoding)
    data.to_excel(file_path.replace('.csv', '.xlsx'), index=False)
    if os.path.exists(file_path):
        os.remove(file_path)


def remove_file(file_path : str):
    if os.path.exists(file_path):
        os.remove(file_path)

import shutil

def copy_file(src_file_path, dest_file_path):
    """
    파일을 복사하여 저장하는 함수
    :param src_file_path: 복사할 파일 경로
    :param dest_file_path: 저장할 파일 경로
    """
    shutil.copy(src_file_path, dest_file_path)


if __name__ == '__main__':
    args = sys.argv
    file_path = args[1]
    if (is_compressed_file(file_path)):
        out_file = unzip_file(file_path)[0]
        csv_to_excel(file_path=out_file)
        remove_file(file_path)

    if (is_csv_file(file_path)):
        csv_to_excel(file_path=file_path)
        remove_file(file_path)

