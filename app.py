import os
import sys
import threading
import webbrowser
from http.server import ThreadingHTTPServer, SimpleHTTPRequestHandler


def get_app_directory():
    if getattr(sys, "frozen", False):
        return os.path.dirname(sys.executable)

    return os.path.dirname(os.path.abspath(__file__))


APP_DIR = get_app_directory()
PORT = 8765


class QuietHandler(SimpleHTTPRequestHandler):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=APP_DIR, **kwargs)

    def log_message(self, format, *args):
        pass


def open_browser():
    webbrowser.open(f"http://127.0.0.1:{PORT}/index.html")


def main():

    os.chdir(APP_DIR)

    server = ThreadingHTTPServer(
        ("127.0.0.1", PORT),
        QuietHandler
    )

    print("=" * 60)
    print("FOCUS TEST LOG ANALYZER")
    print("=" * 60)
    print()
    print(f"Running locally at:")
    print(f"http://127.0.0.1:{PORT}/index.html")
    print()
    print("This application works OFFLINE.")
    print("Close this window to exit.")
    print("=" * 60)

    threading.Timer(
        0.5,
        open_browser
    ).start()

    try:
        server.serve_forever()

    except KeyboardInterrupt:
        pass

    finally:
        server.server_close()


if __name__ == "__main__":
    main()
