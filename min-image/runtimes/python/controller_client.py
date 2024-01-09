import socket
import sys

def send_message(message:str):
    server_address = '/home/yuzishu/share_folder/controller_unix_socket'
    # 创建一个 Unix 域套接字
    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)

    # # 连接到服务器
    # print(f'connecting to {server_address}')
    try:
        sock.connect(server_address)
    except socket.error as msg:
        print(msg)
        sys.exit(1)
    try:
        # 发送数据
        sock.sendall(message.encode())
        data = sock.recv(1024)
    finally:
        # print('closing socket')
        sock.close()


def report_use_service(name:str, version:str, time):
    message = f"load {name} {version} {time}"
    send_message(message)

# def report_unload_service(name:str, version:str):
#     message = f"unload {name} {version}"
#     send_message(message)




