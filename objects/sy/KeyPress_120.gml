if (global.config == "Debug") {
    dbg_data = debug_event("ResourceCounts");
    mem_data = debug_event("DumpMemory");
    gc_collect();
}
