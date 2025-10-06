# 📚 Sistema de Gestión Académica - BDAcademicoLoschamos

## 📋 Descripción del Proyecto
Base de datos académica completa desarrollada en SQL Server para gestionar información de estudiantes, docentes, carreras, asignaturas y calificaciones de una institución educativa.

## 🏗️ Estructura de la Base de Datos

### 📊 Tablas Principales

| Tabla | Descripción |
|-------|-------------|
| `TCarrera` | Almacena las carreras académicas disponibles |
| `TUsuario` | Gestiona usuarios y credenciales de acceso |
| `TAlumno` | Información detallada de los estudiantes |
| `TAsignatura` | Catálogo de asignaturas con sus requisitos |
| `TDocente` | Datos del personal docente |
| `TCarga` | Asignación de docentes a asignaturas por semestre |
| `TNotas` | Registro de calificaciones de los estudiantes |

## 🛠️ Procedimientos Almacenados Implementados

### 🔍 Consultas Básicas
- **`p_ObtenerAlumnosPorCarrera`** - Lista alumnos por carrera específica
- **`p_ObtenerAsignaturasPorDocenteSemestre`** - Asignaturas impartidas por docente en semestre
- **`p_ObtenerDetalleAlumnoNotasSemestre`** - Detalle completo de notas por alumno y semestre

### 📈 Consultas Avanzadas
- **`p_ObtenerAsignaturasSinRequisitos`** - Asignaturas sin requisitos previos
- **`p_ObtenerAlumnosNotasSuperioresPromedio`** - Alumnos con notas sobre el promedio
- **`p_ObtenerAlumnosPorRangoNotas`** - Alumnos por rango de calificaciones
- **`p_ListarDocentesPorNumeroAsignaturas`** - Docentes ordenados por carga académica

### ✏️ Operaciones de Actualización
- **`p_ActualizarNotaFinal`** - Modifica calificaciones finales
- **`p_InsertarNuevaCarga`** - Asigna nuevas cargas académicas a docentes

### 📊 Reportes y Estadísticas
- **`p_CalcularPromedioNotasPorCarrera`** - Promedios por carrera y semestre
- **`p_ListarAlumnosAsignaturasAprobadasDesaprobadas`** - Estado académico por semestre
- **`p_ListarAsignaturasConRequisitos`** - Mapa de requisitos académicos

### 🗑️ Operaciones Administrativas
- **`p_EliminarAlumnoConNotas`** - Elimina alumno y su historial académico

## 🚀 Instalación y Configuración

### Prerrequisitos
- SQL Server 2012 o superior
- SQL Server Management Studio (SSMS)

### Ejecución
1. Ejecutar el script completo de creación de base de datos
2. Verificar que todas las tablas se crearon correctamente
3. Ejecutar los procedimientos almacenados según necesidad

## 📁 Estructura del Proyecto
```
BDAcademicoLoschamos/
├── Database/
│   ├── Scripts/
│   │   ├── 01_CreateDatabase.sql
│   │   ├── 02_CreateTables.sql
│   │   ├── 03_StoredProcedures.sql
│   │   └── 04_SampleData.sql
├── Documentation/
│   └── README.md
└── Examples/
    └── UsageExamples.sql
```

## 🔧 Características Técnicas
- **Motor de Base de Datos:** Microsoft SQL Server
- **Compatibilidad:** SQL Server 2012+
- **Arquitectura:** Modelo relacional normalizado
- **Seguridad:** Gestión de usuarios integrada

## 📝 Uso Básico
```sql
-- Ejemplo: Obtener alumnos por carrera
EXEC p_ObtenerAlumnosPorCarrera @IdCarrera = 1;

-- Ejemplo: Calcular promedios por carrera
EXEC p_CalcularPromedioNotasPorCarrera @Semestre = '2024-1';
```

## 🤝 Contribución
Para contribuir al proyecto, sigue estos pasos:
1. Fork el proyecto
2. Crea una rama para tu feature
3. Commit tus cambios
4. Push a la rama
5. Abre un Pull Request

## 📄 Licencia
Este proyecto está bajo la Licencia MIT.

---

*¿Necesitas que agregue alguna sección específica o que modifique algo del formato?*