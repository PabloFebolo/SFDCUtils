import xml.etree.ElementTree as ET
import argparse

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

# Configuración de nodos y subnodos como una lista de tuplas
nodos_config = [
    ('applicationVisibilities', 'application'),
    ('classAccesses', 'apexClass'),
    ('fieldPermissions', 'field'),
    ('layoutAssignments', 'layout'),
    ('tabVisibilities', 'tab'),
    ('pageAccesses', 'apexPage'),
    ('customMetadataTypeAccesses', 'name'),
    ('customPermissions', 'name'),
    ('customSettingAccesses', 'name'),
    ('flowAccesses', 'flow'),
    ('objectPermissions', 'object'),
    ('recordTypeVisibilities', 'recordType')
]

# Argument parser setup
parser = argparse.ArgumentParser(description="Elimina nodos específicos de un archivo XML")
parser.add_argument('--pkg', type=lambda s: s.split(','), required=True, help='Texto inicial para identificar nodos a eliminar, separado por comas')
parser.add_argument('--profile', type=str, required=True, help='Ruta al archivo de perfil XML a procesar')
args = parser.parse_args()

# Carga inicial y configuración del documento XML
NAMESPACE = "http://soap.sforce.com/2006/04/metadata"
xml_path = args.profile  # Usar el valor de la línea de comando para xml_path
output_path = '../../force-app/main/default/profiles/AdminNew.profile-meta.xml'

tree = ET.parse(xml_path)
root = tree.getroot()
ET.register_namespace('', NAMESPACE)  # Registrar el namespace

# Llamada a la nueva función para eliminar nodos con texto de inicio especificado desde la línea de comandos
total_removed = eliminar_varios_tipos_nodos(root, NAMESPACE, args.pkg, nodos_config)
print(f"Total de nodos eliminados: {total_removed}")

# Guardar el archivo modificado
tree.write(output_path, encoding='utf-8', xml_declaration=True)
