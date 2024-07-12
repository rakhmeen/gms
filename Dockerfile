FROM python:3.12.4-alpine
#changed directory
WORKDIR /app
COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY . .
EXPOSE 8000
# CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
RUN chmod 755 /app/start.sh
CMD ["sh", "start.sh"]