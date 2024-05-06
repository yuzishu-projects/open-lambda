
import sys
import ipdos
shared_addr_base, shared_addr_top = ipdos.get_shared_addresss()
# print("------shared_addr_base", hex(shared_addr_base), "shared_addr_top", hex(shared_addr_top))
def is_builtin_module(module_name):
    # if module_name == "_collections":
    #     return False
    return module_name in sys.builtin_module_names 

class provider_sdk:
    def __init__(self):
        pass
    def prepare_sharing(self):
        self.old_key = list(sys.modules.keys())

    def start_sharing(self):
        new_key = list(sys.modules.keys())
        built_in_modules = []
        for key in new_key:
            if not key in self.old_key:
                # if not is_builtin_module(key):
                    # print("import", key, hex(id(key)))
                sys.shared_states[key] = sys.modules[key] 
                # else:
                    # print("import", key )
                    # built_in_modules.append(key)
                    
    
        import gc
        gc.collect()
        tracked_objects = gc.get_objects()
        sys.shared_states["gc_track_obj_loaded"] = True
        gc.collect()
        sys.shared_states["gc_track_obj"]  = []
        for obj in tracked_objects:
            # if id(obj)>= shared_addr_base  and id(obj)< shared_addr_top:
            sys.shared_states["gc_track_obj"].append(obj)
        print(f"Tracked objects count: {len(tracked_objects)}, {len(sys.shared_states['gc_track_obj'])}", type(tracked_objects))
        
        import ipdos
        ipdos.preGC(sys.shared_states["gc_track_obj"])
        
        
        sys.shared_states["buildin_module_record"] = {}
        dict = sys.shared_states
        def buildin_module_record(map, key, module_name):
            if not map.__contains__(key):
                map[key] =[]
            map[key].append(module_name)
        
        for key in dict:
            if (key[0:3] == "gc_" or key == "buildin_module_record"):
                continue
            if hasattr(dict[key], "sys"):
                buildin_module_record(sys.shared_states["buildin_module_record"], key, "sys")
            for module_name in built_in_modules:
                if hasattr(dict[key], module_name):
                    buildin_module_record(sys.shared_states["buildin_module_record"], key, module_name)
        import time
        import ipdos
        # ipdos.debug()
        import os
        # print("finish pid", os.getpid())
        sys.stdout.flush()
        while True:
            time.sleep(1)

        