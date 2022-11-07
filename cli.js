
import { execSync } from 'child_process'

export default class CLI {

  static exec_command(cmd, cwd, stdio_inherit) {
    try {
      console.log(`>>> EXEC CMD >>> ${cmd}`);
      if (!cwd) cwd = process.cwd()
      const result = execSync(cmd, {
        cwd: cwd,
        stdio: stdio_inherit ? 'inherit' : undefined
      });
      if (!stdio_inherit) {
        return result.toString();
      } else {
        return undefined;
      }
    } catch (e) {
      if (!stdio_inherit) console.error(e.stack);
    }
  }

}
