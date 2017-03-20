FROM gxcore:latest

# USERS
ARG user
ARG userid
RUN useradd --no-log-init -d / -u $userid -g users -G sudo $user
