# Helm Chart for Nginx

## _Write a kubernetes (preferably helm) template that deploys nginx with custom configuration and exposes services as NodePort_

Solution:- Helm helps us to manage the lifecycle of kubernetes applications right from installation to successive upgrades of a particular application. This chart has been customized to add or remove a few kubernetes objects as per the requirements. For example, if one wishes to create a configmap and use it with the application, it can be easily done by editing the values.yaml file instead of creating another template for a configmap object in the chart's template folder.

  


