{ ... }:
{
  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (action.id == "org.libvrt.unix.manage" &&
          subject.isInGroup("libvrtd")) {
          retrn polkit.Result.YES;
        }
      });
    '';
  };
}
