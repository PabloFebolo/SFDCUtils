import xml.etree.ElementTree as ET

def eliminar_nodos_por_criterio(root, namespace, nodo_padre, nodo_hijo, texto_inicio):
    removed_count = 0
    for parent in root.findall(f'{{{namespace}}}{nodo_padre}'):
        child = parent.find(f'{{{namespace}}}{nodo_hijo}')
        if child is not None and child.text.startswith(texto_inicio):
            root.remove(parent)
            removed_count += 1
    return removed_count

# Carga inicial y configuración del documento XML
NAMESPACE = "http://soap.sforce.com/2006/04/metadata"
xml_path = '../../force-app/main/default/profiles/Admin.profile-meta.xml'
output_path = '../../force-app/main/default/profiles/AdminNew.profile-meta.xml'

tree = ET.parse(xml_path)
root = tree.getroot()
ET.register_namespace('', NAMESPACE)  # Registrar el namespace

import xml.etree.ElementTree as ET

def eliminar_nodos_por_criterio(root, namespace, nodo_padre, nodo_hijo, texto_inicio):
    removed_count = 0
    for parent in root.findall(f'{{{namespace}}}{nodo_padre}'):
        child = parent.find(f'{{{namespace}}}{nodo_hijo}')
        if child is not None and child.text.startswith(texto_inicio):
            root.remove(parent)
            removed_count += 1
    return removed_count

def eliminar_varios_tipos_nodos(root, namespace, texto_inicio, nodos_config):
    removed_count = 0
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
    ('recordTypeVisibilities', 'recordType'),
]

# Carga inicial y configuración del documento XML
NAMESPACE = "http://soap.sforce.com/2006/04/metadata"
xml_path = '../../force-app/main/default/profiles/Admin.profile-meta.xml'
output_path = '../../force-app/main/default/profiles/AdminNew.profile-meta.xml'

tree = ET.parse(xml_path)
root = tree.getroot()
ET.register_namespace('', NAMESPACE)  # Registrar el namespace

# Llamada a la nueva función para eliminar nodos con texto de inicio específico
total_removed = 0
total_removed += eliminar_varios_tipos_nodos(root, NAMESPACE, "bar__", nodos_config)
total_removed += eliminar_varios_tipos_nodos(root, NAMESPACE, "copado__", nodos_config)
total_removed += eliminar_varios_tipos_nodos(root, NAMESPACE, "copadoccmint__", nodos_config)
total_removed += eliminar_varios_tipos_nodos(root, NAMESPACE, "copadoQuality__", nodos_config)
total_removed += eliminar_varios_tipos_nodos(root, NAMESPACE, "et4ae5__", nodos_config)
print(f"Total de nodos eliminados: {total_removed}")

# Guardar el archivo modificado
tree.write(output_path, encoding='utf-8', xml_declaration=True)

# Guardar el archivo modificado
tree.write(output_path, encoding='utf-8', xml_declaration=True)
