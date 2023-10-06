FROM jupyterhub/jupyterhub:3

RUN python3 -m pip install --no-cache-dir \
    dockerspawner \
    jupyterhub-nativeauthenticator

CMD ["jupyterhub", "-f", "/srv/jupyterhub/jupyterhub_config.py"]
