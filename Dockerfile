FROM python:slim-bullseye
ARG USERNAME=ca
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # give non-root access to /dev/tty*
    && usermod -a -G dialout $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo libxml2 git htop bash-completion nano minicom \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME

WORKDIR /home/$USERNAME
RUN mkdir -p /home/$USERNAME/.local/bin
ENV PATH="${PATH}:/home/${USERNAME}/.local/bin"
COPY config .callattendant
RUN sudo chown -R $USERNAME:$USERNAME .
RUN pip3 install -e git+https://github.com/advfr/callattendant.git@master#egg=callattendant
ENTRYPOINT callattendant --config app.cfg
EXPOSE 5000
