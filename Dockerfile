FROM apache/spark:3.5.1

USER root

# Install Python + JupyterLab + libs
RUN apt-get update && \
    apt-get install -y python3-pip python3-dev build-essential && \
    pip3 install jupyterlab pyspark numpy pandas && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 🔥 Create needed directories for the spark user
RUN mkdir -p /home/spark/.local/share/jupyter/runtime && \
    mkdir -p /opt/spark-notebooks && \
    chown -R spark:spark /home/spark && \
    chown -R spark:spark /opt/spark-notebooks

# Switch user
USER spark

WORKDIR /opt/spark-notebooks
EXPOSE 8888 4040

CMD ["python3", "-m", "jupyterlab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token=''"]
