FROM ibmcom/websphere-liberty:latest

   # Add my app 
   COPY --chown=1001:0  autoscale-webapp.war /opt/ibm/wlp/usr/servers/defaultServer/dropins/

   RUN configure.sh