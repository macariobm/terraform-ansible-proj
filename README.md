

# Sobre o projeto (English below)

Esse repositório é uma forma de sistematizar meus estudos de Terraform e Ansible naquilo que eles são melhores: provisionamento e gerenciamento de infra, respectivamente.

Seu objetivo é usar Terraform para provisionar um ambiente de dev na AWS com:
 - um firewall simples permitindo conexão SSH (porta 22) e HTTPS (porta 443)
 - chaves pública e privada geradas no provisionamento
 - ao fim, usar os IPs públicos das instâncias como Output

Usando o script `fetch-ips.sh` pegamos o output do Terraform e geramos o arquivo `hosts` para o Ansible usar de inventório.

O playbook do Ansible:
 - dá update e upgrade nos pacotes da instância
 - instala os pacotes necessários para docker e python
 - configura o docker (cria diretório, adiciona a chave, o repositório, os pacotes)
 - cria e adiciona um usuário ao grupo 'docker' permitindo utilizar comandos da Docker CLI mesmo _sem privilégios de root_
 - configura as chaves SSH para o usuário
 - copia a Dockerfile para as instâncias, faz o build da imagem e printa na tela seu ID
 - cria e roda os containers com pseudo-TTY e STDIN aberto, equivalente ao comando `docker run -it <ID DA IMAGEM>`

### Dependências

Na máquina de controle é necessário o Terraform, Python e Ansible.

Para o Ansible, precisaremos de collections que não fazem parte do *Ansible core*. 

Usaremos:

`ansible-galaxy collection install ansible.posix`

`ansible-galaxy collection install community.docker`


### Como usar
São necessárias credencias da AWS. Elas podem ser exportadas como variáveis de ambiente por meio dos comandos:
`export AWS_ACCESS_KEY_ID="access_key"`
`export AWS_SECRET_ACCESS_KEY="secret_key"`

- Em **./terraform-ansible-proj** inicialize a Terraform CLI com `terraform init`

- Use `terraform plan -out plan01` para criar o plano de execução e visualizar as mudanças na infraestrutura antes de aplicá-las

- Use `terraform apply "plan01"` para aplicar o plano e provisionar as instâncias. Na CLI será pedido seu usuário da AWS

- Rode o `fetch-ips.sh` para criar o arquivo `hosts`

- Em **./terraform-ansible-proj/configuring-servers** use o comando `ansible-playbook -i hosts main.yml` para aplicar o playbook



### Licensa

GNU GPLv3
