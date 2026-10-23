{ pkgs, lib, ... }: {
    config = (lib.mkMerge [
        {

            # Enable ROCm
            hardware.amdgpu = {
                initrd.enable = true;
                opencl.enable = true;
                #rocm.enable = true;
            };

            virtualisation = {
                oci-containers = {
                    backend = "podman";
                    containers = {
                        ollama = {
                            image = "ollama/ollama:rocm";
                            ports = [ "11434:11434" ];
                            volumes = [ "ollama:/root/.ollama" ];
                            extraOptions = [
                                "--device=/dev/kfd"
                                "--device=/dev/dri"
                                "--group-add=video"
                            ];
                            environment = {
                                HCC_AMDGPU_TARGET = "gfx1100";
                                OLLAMA_HOST = "0.0.0.0";
                                OLLAMA_REASONING_PARSER = "deepseek_r1";
                            };
                        };
                        sillytavern = {
                            image = "ghcr.io/sillytavern/sillytavern:1.18.0";
                            ports = [ "8000:8000" ];
                            volumes = [
                                "st-data:/home/node/app/data:rw"
                                "st-config:/home/node/app/config:rw"
                                "st-plugins:/home/node/app/plugins:rw"
                                "st-extensions:/home/node/app/public/scripts/extensions/third-party:rw"
                            ];
                        };
                        speaches = {
                            image = "ghcr.io/rsxdalv/tts-webui:main";
                            ports = [ "8001:3000" ];
                            volumes = [
                                "speaches-cache:/home/ubuntu/.cache/huggingface/hub:rw"
                            ];
                        };
                        open-webui = {
                            image = "ghcr.io/open-webui/open-webui:v0.11.0";
                            ports = [ "3000:8080" ]; # Access UI at http://localhost:3000
                            volumes = [ "open-webui:/app/backend/data" ];
                            environment = {
                                # Connect to Ollama. 'ollama' is the container name, thanks to Podman's internal DNS.
                                OLLAMA_BASE_URL = "http://ollama:11434";
                                # Optional: Add web search capabilities
                                # ENABLE_WEB_SEARCH = "true";
                                # WEB_SEARCH_ENGINE = "searxng"; # or "tavily", "brave"
                                # SEARXNG_QUERY_URL = "http://searxng:8080/search?q=<query>";
                            };
                            dependsOn = [ "ollama" ];
                        };
                        open-terminal = {
                            image = "ghcr.io/open-webui/open-terminal";
                            volumes = [ "open-terminal:/home/user" ];
                            environment = {
                                OPEN_TERMINAL_API_KEY = "1jGqHzaxIKTWq1havpRog73AHRmIv5nGUrvyEU4A9kTg5_i6x-kUpdbQqwpOU4i-";
                            };
                        };
                    };
                };
            };

            networking.firewall.allowedTCPPorts = [ 3000 ];

        }
    ]);
}