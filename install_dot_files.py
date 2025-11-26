
import subprocess
import threading
import queue
import os

class cmd_shell:
    def __init__(self ):

        git_bash_key = 'GIT_BASH'
        if git_bash_key in os.environ:
            bash_path = os.environ[git_bash_key]
        else:
            print(f'please set environment variable {git_bash_key}')
            exit(1)

        self.process = subprocess.Popen(
            [bash_path],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            #shell=True,
            bufsize=1,
            env=os.environ,
            universal_newlines=True,
            encoding='utf-8',
        )

        # two queues: one for stdout, one for stderr
        self.stdout_q = queue.Queue()
        self.stderr_q = queue.Queue()

        # reader threads
        threading.Thread(target=self._reader, args=(self.process.stdout, self.stdout_q), daemon=True).start()
        threading.Thread(target=self._reader, args=(self.process.stderr, self.stderr_q), daemon=True).start()


    def run(self, *cmd):
        command = " ".join(list(cmd))

        """Send a command and return stdout + stderr output."""

        self.process.stdin.write(_echo_cmd(command)+ "\n")
        self.process.stdin.flush()

        self.process.stdin.write(command + "\n")
        self.process.stdin.flush()

        self.process.stdin.write(_return_code_cmd()+ "\n")
        self.process.stdin.flush()

        self.process.stdin.write(_end_cmd()+ "\n")
        self.process.stdin.flush()

        stdout_lines = []
        stderr_lines = []
        retcode = 0


        while True:
            something_wrong = False
            try:
                line = self.stdout_q.get_nowait()
                stdout_lines.append(line)
            except queue.Empty:
                pass

            try:
                line = self.stderr_q.get_nowait()
                stderr_lines.append(line)
                something_wrong=True
            except queue.Empty:
                pass

            if _check_output_complete(stdout_lines):
                break  # No more output for now


        out=''.join(stdout_lines)
        print(out.strip())

        if len(stderr_lines)>0:
            err=''.join(stderr_lines)
            print(err)

        retcode = _get_return_code(stdout_lines)
        if retcode!=0:
            exit(retcode)


    def _reader(self, pipe, q):
        for line in pipe:
            q.put(line)

    def close(self):
        self.process.terminate()


end_str='----'

def _check_cmd_begins(lines):
    return len(lines) > 0 and  lines[-1].strip() == end_str

def _check_output_complete(lines):
    return len(lines)>0 and  lines[0][0]=='$' and  lines[-1].strip() == end_str 

def _get_return_code(lines):
    return int(lines[-2].strip())

def _echo_cmd(cmd):
    return 'echo $ '+ cmd

def _end_cmd():
    return 'echo '+ end_str

def _return_code_cmd():
    return 'echo $?'




def tverse_one_depth_directory(directory,depth,max_depth,fn):

    if depth >= max_depth:
        return

    for entry in os.listdir(directory):
        entry_path = os.path.join(directory, entry)  # Full path
        is_dir=os.path.isdir(entry_path)
        if is_dir:
            tverse_one_depth_directory(entry_path,depth+1,max_depth,fn)
        fn(entry_path,depth,is_dir)


def replace_seperator(path):
    return path.replace('\\','/')

def start_with_dot(path):
    name=os.path.basename(path)
    return name[0]=='.'

def create_link(entry_path,depth,is_dir,cmd):
    if depth==1 and start_with_dot(entry_path):
        home = os.path.expanduser("~")
        name = os.path.basename(entry_path)
        link_name = os.path.join(home,name)

        target_path = os.path.abspath(entry_path)
        link_path = os.path.abspath(link_name)
        target_path = replace_seperator(target_path)
        link_path = replace_seperator(link_path)

        print(f'create link: {target_path} <- {link_path}');
        if os.path.exists(link_path):
           cmd.run('rm',link_path,'-rf')
        os.symlink(target_path,link_path)

        parent_name=os.path.dirname(target_path)
        take_effect_file = os.path.join(parent_name,'take_effect.sh')
        take_effect_file = replace_seperator(take_effect_file)
        if os.path.exists(take_effect_file):
            cmd.run('sh',take_effect_file)


cmd = cmd_shell()
fn=lambda entry_path,depth,is_dir:create_link(entry_path,depth,is_dir,cmd)

tverse_one_depth_directory('.',0,2,fn)
