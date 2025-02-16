from fastapi import FastAPI, HTTPException
import uvicorn
from pydantic import BaseModel
from transformers import AutoModelForCausalLM, AutoTokenizer, pipeline
import torch
from fastapi.middleware.cors import CORSMiddleware