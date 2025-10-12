# Usar una imagen base ligera de Python 3.12
FROM python:3.12-slim

# Crear un grupo y usuario no-root llamado 'appuser' por motivos de seguridad
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el archivo de dependencias al contenedor
COPY requirements.txt .

# Instalar las dependencias del proyecto sin guardar archivos temporales
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el código de la aplicación al contenedor
COPY app ./app

# Cambiar la propiedad de los archivos al usuario no-root
RUN chown -R appuser:appuser /app

# Usar el usuario no-root para ejecutar la aplicación
USER appuser

# Exponer el puerto 5000 (por ejemplo, para una app Flask)
EXPOSE 5000

# Comando por defecto para ejecutar la aplicación
CMD ["python", "app/app.py"]
