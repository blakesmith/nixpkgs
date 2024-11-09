{ lib
, buildGoModule
, fetchFromGitHub
, unstableGitUpdater
}:

let
  indigo =
    let
      rev = "6e3c2e3e2dab4fac8b6c21e19292c5238e7b2282";
    in

    buildGoModule {
      pname = "bluesky";
      version = "0-unstable-2024-11-09";

      src = fetchFromGitHub {
        inherit rev;
        owner = "bluesky-social";
        repo = "indigo";
        hash = "sha256-Z4OdorEI59CGUUPNJH933SSrjfJeELaddk9CHIHEq18=";
      };

      doCheck = false;

      ldflags = [
        "-X github.com/carlmjohnson/versioninfo.Revision=${rev}"
      ];

      vendorHash = "sha256-T+jtxubVKskrLGTUa4RI24o/WTSFCBk60HhyCFujPOI=";

      passthru.updateScript = unstableGitUpdater {
        hardcodeZeroVersion = true;
      };

      meta = {
        description = "Bluesky's atproto code / services in go";
        homepage = "https://github.com/bluesky-social/indigo";
        license = with lib.licenses; [
          mit
          asl20
        ];
        maintainers = with lib.maintainers; [ blakesmith pyrox0 ];
      };
    };
in

indigo
