import ipdos
import sys
import _sre
import _operator
import itertools
import _collections
import _functools
import errno
import _ast
import pwd
import atexit
import gc
import _string
import os


modlue_map = {
    # "sys":sys,
    # "_sre":_sre,
    # "_operator":_operator,
    # "itertools":itertools,
    # "_collections":_collections,
    # "_functools":_functools,
    # "errno":errno,
    # "_ast":_ast,
    # "pwd":pwd,
    # "atexit":_string,
    # "gc":gc,
    # "_string":_string
}

Global_Service = {}

class IpdosClient:
    def __init__(self) -> None:
        ipdos.init()
        self.loaded_services = []
        # self.current_service = None
        # self.current_version = None

    def load_service(self, name:str, version:str)->str:
        service_key = name+version
        # print("load service", name, version)
        if service_key in Global_Service:
            return service_key
        else:
            Global_Service[service_key] = True
        id = ipdos.load_service(name, version)
        if id == -1:
            return ""
        # print("load service", name, version, id)
        self.loaded_services.append((name, version))
        
        dict = sys.shared_states[service_key]["buildin_module_record"]
        for key in dict:
            for name in dict[key]:
                if name == "sys":
                    continue
                setattr(sys.shared_states[service_key][key], name, modlue_map[name])
        return service_key
    def report_load_service(self, name:str, version:str, t):
        '''
        t (seconds), how much seconds the process will keep library in memory
        '''
        import controller_client
        # print("report load service", name, version, t)
        controller_client.report_use_service(name, version, t)
    def set_service(self, service_key):
        if service_key == "":
            ipdos.unset_loading()
            return True
        ipdos.set_loading(service_key)
        return True
    
    def unset_service(self):
        ipdos.unset_loading()
        return True
    
    # def finish(self):
    #     import controller_client
    #     for (name, version) in self.loaded_services:
    #         controller_client.report_unload_service(name, version)