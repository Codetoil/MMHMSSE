# syntax=docker/dockerfile:1
FROM swift:5.10-jammy

RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

COPY .. ~/Game
WORKDIR ~/Game

RUN wget https://github.com/godotengine/godot/releases/download/4.2.1-stable/Godot_v4.2.1-stable_linux.x86_64.zip
RUN unzip Godot_v4.2.1-stable_linux.x86_64.zip
RUN wget https://github.com/godotengine/godot/releases/download/4.2.1-stable/Godot_v4.2.1-stable_export_templates.tpz
RUN mkdir -p ~/.local/share/godot/export_templates/
RUN unzip Godot_v4.2.1-stable_export_templates.tpz -d ~/.local/share/godot/export_templates
RUN mv ~/.local/share/godot/export_templates/templates ~/.local/share/godot/export_templates/4.2.1.stable
RUN mkdir -p Godot/bin/debug/Linux/x86_64
RUN mkdir -p Godot/bin/release/Linux/x86_64
RUN mkdir -p Godot/addons/game_swift/debug/Linux/x86_64
RUN /bin/sh ./copy-swift-binaries-linux-x86_64.sh

CMD ["/bin/sh", "install-linux-x86_64.sh"]