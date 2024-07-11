FROM python:3.12.4-alpine
WORKDIR /idk
COPY requirements.txt ./
RUN pip install --no-cache-dir --upgrade -r /idk/requirements.txt
COPY . .
EXPOSE 8000
# CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
RUN chmod 755 /idk/start.sh
CMD ["sh", "start.sh"]