# Usamos una imagen base de Python
FROM python:3.11

# Establecemos el directorio de trabajo en el contenedor
WORKDIR /app

# Copiamos los archivos necesarios
COPY . /app

# Instalamos dependencias
RUN pip install -r requirements.txt

# Exponemos el puerto 5004
EXPOSE 5004

# Comando para ejecutar la aplicación
CMD ["python", "app.py"]
