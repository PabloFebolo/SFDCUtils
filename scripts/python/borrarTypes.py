import xml.etree.ElementTree as ET
import argparse
import os

def eliminar_nodos_por_criterio(root, namespace, names):
    new_root = ET.Element(root.tag, xmlns=namespace)
    for types in root.findall(f'{{{namespace}}}types'):
        name = types.find(f'{{{namespace}}}name')
        if name is not None and name.text in names:
            new_root.append(types)
    return new_root

def indent(elem, level=0):
    i = "\n" + level*"  "
    if len(elem):
        if not elem.text or not elem.text.strip():
            elem.text = i + "  "
        if not elem.tail or not elem.tail.strip():
            elem.tail = i
        for elem in elem:
            indent(elem, level+1)
        if not elem.tail or not elem.tail.strip():
            elem.tail = i
    else:
        if level and (not elem.tail or not elem.tail.strip()):
            elem.tail = i

def save_xml(root, output_path):
    # Aplicar la indentación
    indent(root)
    # Escribir el archivo XML con finales de línea \n y formateo adecuado
    tree = ET.ElementTree(root)
    with open(output_path, 'wb') as f:
        tree.write(f, encoding='utf-8', xml_declaration=True)

parser = argparse.ArgumentParser(description="Filtra nodos types de un archivo XML.")
parser.add_argument('--input', required=True, help='Ruta al archivo XML de entrada.')
parser.add_argument('--output', required=True, help='Ruta al archivo XML de salida.')
parser.add_argument('--names', required=True, nargs='+', help='Nombres de los types a incluir, separados por espacios.')
args = parser.parse_args()

tree = ET.parse(args.input)
root = tree.getroot()
ET.register_namespace('', "http://soap.sforce.com/2006/04/metadata")

filtered_root = eliminar_nodos_por_criterio(root, "http://soap.sforce.com/2006/04/metadata", args.names)
save_xml(filtered_root, args.output)

print("Archivo generado con éxito.")
