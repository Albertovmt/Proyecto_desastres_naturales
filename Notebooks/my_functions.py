import pandas as pd
from IPython.display import display

import requests
import os
from dotenv import load_dotenv

load_dotenv()

def first_glace(df):

    rows, columns = df.shape
    print(f'This Dataset has {rows} rows, and {columns} columns')
    print('='*45, end='\n\n')
    
    print('first glace of the Dataset: ', end='\n\n')
    display(df.head())
    print('='*45, end='\n\n')
    
    print('Type of data: ', end='\n\n')
    print(df.dtypes)
    print('='*45, end='\n\n')

def examine_data(df):

    print('Number of unique values: ', end='\n\n')
    print(df.nunique())
    print('='*45, end='\n\n')

    print('Number of null values: ', end='\n\n')
    print(df.isnull().sum())
    print('='*45, end='\n\n')

    print('Number of duplicated rows: ', end='\n\n')
    print(df.duplicated().sum())
    print('='*45, end='\n\n')

def descriptive_statistics(df):

    print('Descriptive statistics for numerical variables: ', end='\n\n')
    display(df.describe().T)
    print('='*45, end='\n\n')
    
    print('Descriptive statistics for categorical variables: ', end='\n\n')
    display(df.describe(include='str').T)
    print('='*45, end='\n\n')

def standardize_columns(df):
    df.columns = df.columns.str.lower().str.strip().str.replace(' ','_')
    return df

def normalize_dates(DataFrame,column_year,column_month,column_day):
    
    cols = {column_year:'year', column_month:'month', column_day:'day'}
    df_date = DataFrame[[column_year,column_month,column_day]].rename(columns = cols)
    return pd.to_datetime(df_date, errors='coerce')

def call_api(row):

    my_key = os.getenv("API_KEY")
    
    url = 'https://api-bdc.net/data/reverse-geocode'
    parameters = {"key": my_key,"localityLanguage": "en",'longitude': row['longitude'],'latitude': row['latitude']}
    
    try:
        response = requests.get(url, params=parameters)
        if response.status_code == 200:
            data = response.json()
        
                # Extraer País
            pais = data.get('countryName', 'Desconocido')
            
            # Extraer Continente (Region)
            continente = data.get('continent', 'Desconocido')
            
            # Extraer Subregión (Administrativo Nivel 1)
            # Usamos un try/except por si la estructura del array varía
            try:
                subregion = data['localityInfo']['administrative'][1]['name']
            except (KeyError, IndexError):
                subregion = 'Desconocido'
            
            return {
                'country': pais,
                'subregion': subregion,
                'region': continente
                }
        else:
            print("Status error:", response.status_code)
            return None
    except Exception as e:
        print(f"Error: {e}")
        return None