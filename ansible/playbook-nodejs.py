---
- name: Base states
  hosts: web
  become: yes 
  roles:
    - role: repo-epel 
    - role: nodejs
