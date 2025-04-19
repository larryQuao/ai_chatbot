from imports import *

app = FastAPI()

origins = [
    "http://localhost",
    "http://localhost:8080",
    "http://localhost:8000",    
    "http://127.0.0.1",
    "http://127.0.0.1:8080",
    "http://127.0.0.1:8000",
    "*",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

try:
    tokenizer = AutoTokenizer.from_pretrained("microsoft/DialoGPT-medium")
    model = AutoModelForCausalLM.from_pretrained("microsoft/DialoGPT-medium")
    print("Model loaded successfully!")
except Exception as e:
    print(f"Error loading model: {e}")
    tokenizer = None
    model = None

conversational_histories = {}

def generate_response(user_message, conversation_id):
    # input_text = user_message + tokenizer.eos_token
    # input_ids = tokenizer.encode(input_text, return_tensors="pt")
    # attention_mask = torch.ones_like(input_ids)

    if conversation_id not in conversational_histories:
        conversational_histories[conversation_id] = pipeline("text-generation", model=model, tokenizer=tokenizer)

    # conversation = conversational_histories[conversation_id]

    input_text = user_message
    input_ids = tokenizer.encode(input_text, return_tensors="pt")
    attention_mask = torch.ones_like(input_ids)

    chat_history_ids = model.generate(
        input_ids,
        attention_mask=attention_mask,
        max_length=1000,
        pad_token_id=tokenizer.eos_token_id
    )

    full_conversation = tokenizer.decode(chat_history_ids[0], skip_special_tokens=True)
    print(f"generate_response: Full Conversation: {full_conversation}")

    try:
        user_message_end_index = full_conversation.index(user_message) + len(user_message)
        response_text = full_conversation[user_message_end_index:].strip()
        print(f"generate_response: Extracted Response Text: {response_text}")
    except ValueError
        response_text = "Sorry, I had trouble understanding the response."
        print(f"generate_response: Error extracting response - ValueError") 
    if not response_text:
        response_text = "Sorry, I don't have a response right now."
        print(f"generate_response: Empty response after extraction - Fallback") 

    return response_text

class ChatRequest(BaseModel):
    message: str
    conversation_id: str

class ChatResponse(BaseModel):
    response: str

@app.post("/chat", response_model=ChatResponse)
async def chat(request_data: ChatRequest):
    if tokenizer is None or model is None:
        raise HTTPException(status_code=500, detail="Model Not Loaded, Please Try Again Later")
    try:
        user_message = request_data.message
        if not user_message:
            raise HTTPException(status_code=400, detail="No message Provided")

        conversation_id = request_data.conversation_id
        response_text = generate_response(user_message, conversation_id)

        return ChatResponse(response=response_text)

    except Exception as e:
        print(f"Error during chatbot interaction: {e}")
        raise HTTPException(status_code=500, detail="Something went wrong during message processing")
    
@app.get("/")
async def root():
    return {"message": "This is a backend for my AI chabot Application."}

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000, log_level="debug")
