class_name Memories;

var memories: Array[Memory] = [];

func AddMemory(_memory: Memory) -> :
    memories.append(_memory);

func GetRecentMemories() - Array[Memory]:
    return