from sqlalchemy import Column, Integer, String, Boolean
from sqlalchemy.ext.declarative import declarative_base


Base = declarative_base()


class Cliente(Base):
    __tablename__ = 'GUEST'
    guest_id = Column(Integer, primary_key=True)
    PASSPORT_ID = Column(String(50), nullable=False, unique=True)
    ID_CARD = Column(String(50), nullable=False, unique=True)
    first_name = Column(String(50), nullable=True)
    last_name = Column(String(50), nullable=True)
    email = Column(String(100), nullable=True, unique=True)
    phone = Column(String, nullable=False)
    nationalidad = Column(String(50), nullable=True)