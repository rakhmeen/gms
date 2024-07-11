from fastapi import FastAPI, HTTPException, Depends
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy.future import select
from sqlalchemy import text
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
import os
from DataBase import Base,engine

app = FastAPI()

@app.on_event("startup")
async def startup_event():
    await init_db()

async def init_db():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
        with open("/docker-entrypoint-initdb.d/init.sql", "r") as file:
            sql_statements = file.read().split(";")
            for statement in sql_statements:
                if statement.strip():
                    await conn.execute(text(statement))

@app.get("/")
async def read_root():
    return {"message": "Hello, please work. I am tired."}
