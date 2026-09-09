# MSDS 442 — Lab 10: Final Project Phase 3

## What it does
Final phase of the term's multi-agent final project — extends the Phase 2 system to support
stateful multi-turn conversations using LangGraph, with a MemorySaver checkpointer for
per-conversation state persistence across 3 selected agents (Business, Membership, Order),
each demonstrated across 3 scripted multi-turn user stories.

## Files
- `Deshpande_Phase3.ipynb`

## Techniques/libraries used
- LangGraph (`StateGraph`, `MemorySaver` checkpointer, `Annotated[List[BaseMessage], add_messages]`)
- Chroma vector stores (RAG per agent)
- LangChain
