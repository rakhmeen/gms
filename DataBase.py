 
from sqlalchemy import create_engine, text
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from dotenv import load_dotenv
import os

load_dotenv()

# Load database URL from environment variable
DATABASE_URL = os.getenv('DATABASE_URL')
 

# Create SQLAlchemy engine and sessionmaker
engine = create_async_engine(DATABASE_URL, echo=True)
async_session = sessionmaker(
    engine, expire_on_commit=False, class_=AsyncSession
)
Base = declarative_base()
async def get_db():
    async with async_session() as session:
        yield session
 

  
