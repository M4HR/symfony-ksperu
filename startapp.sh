#!/bin/sh

# Suprimir advertencias de deprecación de Python
export PYTHONWARNINGS="ignore::DeprecationWarning"

# Desactivar aceleración por hardware y otros ajustes para entorno Docker
exec /usr/bin/qutebrowser \
    --qt-flag disable-gpu \
    "$@"