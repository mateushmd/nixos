{ lib, myLib }:
let
  mkWifiProfile = { 
    id,
    ssid,
    uuid,
    autoconnect,
    psk ? "",
  }: {
    connection = {
      inherit id uuid;

      # interface-name = "wlp2s0";
      # permissions = "";
      type = "wifi";
    } // lib.optionalAttrs autoconnect { autoconnect = true; };

    ipv4 = {
      method = "auto";
    };

    ipv6 = {
      addr-gen-mode = "default";
      method = "auto";
    };

    wifi = {
      inherit ssid;

      mode = "infrastructure";
    };

    wifi-security = {
      auth-alg = "open";
      key-mgmt = "wpa-psk";
    } // (if psk != "" then {
      inherit psk;
    }else {
      psk-flags = "1";
    });
  };
in
{
  home = mkWifiProfile {
    id = "home";
    ssid = "Chenri#48155";
    uuid = "1c349ff5-7fb1-4f5b-ba1c-aee3cf0e9099";
    autoconnect = true;
    psk = "$WIFI_HOME_PSK";
  };

  phone = mkWifiProfile {
    id = "phone";
    ssid = "mateus";
    uuid = "fb828cff-4773-4c1a-b854-5e2ead35b430";
    autoconnect = false;
    psk = "$WIFI_PHONE_PSK";
  };

  puc = lib.recursiveUpdate (myLib.removeAttrsRec (mkWifiProfile {
    id = "puc";
    ssid = "PUCMinas";
    uuid = "08949d9c-2182-4bc8-8ac7-9ed55133b928";
    autoconnect = true;
  }) ["wifi-security" "connection.interface-name"]) {
    "802-1x" = {
      eap = "peap";
      identity = "880541@pucminas.br";
      password-flags = "1";
      phase2-auth = "mschapv2";
    };

    ipv6.addr-gen-mode = "stable-privacy";

    wifi-security = {
      key-mgmt = "wpa-eap";
    };
  };

  puc-eduroam = lib.recursiveUpdate (myLib.removeAttrsRec (mkWifiProfile {
    id = "puc-eduroam";
    ssid = "eduroam";
    uuid = "ac653a5c-a178-4ea2-8b0c-4384115d5700";
    autoconnect = false;
  }) ["wifi-security" "connection.interface-name"]) {
    "802-1x" = {
      eap = "peap";
      identity = "880541@pucminas.br";
      password-flags = "1";
      phase2-auth = "mschapv2";
    };

    ipv6.addr-gen-mode = "stable-privacy";

    wifi-security = {
      key-mgmt = "wpa-eap";
    };
  };

  ray = mkWifiProfile {
    id = "ray";
    ssid = "RAYANNE";
    uuid = "5c3e1806-7f7f-4248-9a51-ff37f66ab5cf";
    autoconnect = true;
  };
}
