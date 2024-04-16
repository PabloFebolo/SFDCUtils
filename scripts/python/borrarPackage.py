import xml.etree.ElementTree as ET
import argparse
import os
import json

def eliminar_nodos_por_criterio(root, namespace, nodo_padre, nodo_hijo, texto_inicio):
    removed_count = 0
    for parent in root.findall(f'{{{namespace}}}{nodo_padre}'):
        child = parent.find(f'{{{namespace}}}{nodo_hijo}')
        if child is not None and child.text.startswith(texto_inicio):
            root.remove(parent)
            removed_count += 1
    return removed_count

def eliminar_varios_tipos_nodos(root, namespace, textos_inicio, nodos_config):
    removed_count = 0
    for texto_inicio in textos_inicio:
        for nodo_padre, nodo_hijo in nodos_config:
            removed_count += eliminar_nodos_por_criterio(root, namespace, nodo_padre, nodo_hijo, texto_inicio)
    return removed_count

parser = argparse.ArgumentParser(description="Elimina nodos específicos de un archivo XML")
parser.add_argument('--pkg', type=lambda s: s.split(','), required=True, help='Texto inicial para identificar nodos a eliminar, separado por comas')
parser.add_argument('--profile', type=str, required=True, help='Ruta al archivo de perfil XML a procesar')
args = parser.parse_args()

NAMESPACE = "http://soap.sforce.com/2006/04/metadata"
xml_path = args.profile

# Cargar configuración de nodos desde JSON
json_path = 'componentTypesPermissions.json'
with open(json_path, 'r') as file:
    data = json.load(file)
    nodos_config = [(item['node'], item['subnode']) for item in data['types']]

base_dir = os.path.dirname(xml_path)
base_name = os.path.basename(xml_path)
file_root, file_extension = os.path.splitext(base_name)
first_part = file_root.split('.')[0] + "New"
remaining_parts = '.'.join(file_root.split('.')[1:]) if '.' in file_root else ''
output_filename = f"{first_part}.{remaining_parts}{file_extension}"
output_path = os.path.join(base_dir, output_filename)

tree = ET.parse(xml_path)
root = tree.getroot()
ET.register_namespace('', NAMESPACE)

total_removed = eliminar_varios_tipos_nodos(root, NAMESPACE, args.pkg, nodos_config)
print(f"Total de nodos eliminados: {total_removed}")

# Escribir el archivo XML con finales de línea \n
with open(output_path, 'wb') as f:
    tree.write(f, encoding='utf-8', xml_declaration=True)
