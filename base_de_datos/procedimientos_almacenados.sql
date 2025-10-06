USE BDAcademicoLoschamos
GO

-- 1. Obtener Asignaturas sin Requisitos
CREATE PROCEDURE p_ObtenerAsignaturasSinRequisitos
AS
BEGIN
    SELECT
        CodAsignatura,
        Asignatura
    FROM
        TAsignatura
    WHERE
        CodRequisito IS NULL;
END
GO

-- Ejemplo de uso:
EXEC p_ObtenerAsignaturasSinRequisitos;

-- 2. Actualizar Nota Final
CREATE PROCEDURE p_ActualizarNotaFinal
    @CodAlumno CHAR(5),
    @CodAsignatura CHAR(3),
    @Semestre VARCHAR(20),
    @NuevaNotaFinal DECIMAL(4,2)
AS
BEGIN
    UPDATE TNotas
    SET NotaFinal = @NuevaNotaFinal
    WHERE
        CodAlumno = @CodAlumno AND
        CodAsignatura = @CodAsignatura AND
        Semestre = @Semestre;
END
GO

-- Ejemplo de uso:
EXEC p_ActualizarNotaFinal 'A0001', 'S01', '2010-I', 16.5;

-- 3. Insertar Nueva Carga Académica
CREATE PROCEDURE p_InsertarNuevaCarga
    @IdCarga INT,
    @CodDocente CHAR(3),
    @CodAsignatura CHAR(3),
    @Semestre VARCHAR(20)
AS
BEGIN
    INSERT INTO TCarga (IdCarga, CodDocente, CodAsignatura, Semestre)
    VALUES (@IdCarga, @CodDocente, @CodAsignatura, @Semestre);
END
GO

-- Ejemplo de uso:
EXEC p_InsertarNuevaCarga 17, 'D01', 'S17', '2012-I';

-- 4. Listar Docentes por Número de Asignaturas
CREATE PROCEDURE p_ListarDocentesPorNumeroAsignaturas
AS
BEGIN
    SELECT
        D.CodDocente,
        D.APaterno,
        D.AMaterno,
        D.Nombres,
        COUNT(C.CodAsignatura) AS NumeroAsignaturas
    FROM
        TDocente D
    LEFT JOIN
        TCarga C ON D.CodDocente = C.CodDocente
    GROUP BY
        D.CodDocente, D.APaterno, D.AMaterno, D.Nombres
    ORDER BY
        NumeroAsignaturas DESC;
END
GO

-- Ejemplo de uso:
EXEC p_ListarDocentesPorNumeroAsignaturas;

-- 5. Obtener Alumnos con Notas Superiores a un Promedio
CREATE PROCEDURE p_ObtenerAlumnosNotasSuperioresPromedio
    @CodAsignatura CHAR(3),
    @Semestre VARCHAR(20)
AS
BEGIN
    SELECT
        A.CodAlumno,
        A.APaterno,
        A.AMaterno,
        A.Nombres,
        N.NotaFinal
    FROM
        TAlumno A
    INNER JOIN
        TNotas N ON A.CodAlumno = N.CodAlumno
    WHERE
        N.CodAsignatura = @CodAsignatura AND
        N.Semestre = @Semestre AND
        N.NotaFinal > (SELECT AVG(NotaFinal) FROM TNotas WHERE CodAsignatura = @CodAsignatura AND Semestre = @Semestre);
END
GO

-- Ejemplo de uso:
EXEC p_ObtenerAlumnosNotasSuperioresPromedio 'S01', '2010-I';

-- 6. Listar Asignaturas con sus Requisitos
CREATE PROCEDURE p_ListarAsignaturasConRequisitos
AS
BEGIN
    SELECT
        A.CodAsignatura,
        A.Asignatura,
        R.Asignatura AS Requisito
    FROM
        TAsignatura A
    LEFT JOIN
        TAsignatura R ON A.CodRequisito = R.CodAsignatura;
END
GO

-- Ejemplo de uso:
EXEC p_ListarAsignaturasConRequisitos;

-- 7. Obtener Alumnos por Rango de Notas
CREATE PROCEDURE p_ObtenerAlumnosPorRangoNotas
    @NotaMinima DECIMAL(4,2),
    @NotaMaxima DECIMAL(4,2)
AS
BEGIN
    SELECT
        A.CodAlumno,
        A.APaterno,
        A.AMaterno,
        A.Nombres,
        N.NotaFinal
    FROM
        TAlumno A
    INNER JOIN
        TNotas N ON A.CodAlumno = N.CodAlumno
    WHERE
        N.NotaFinal BETWEEN @NotaMinima AND @NotaMaxima
    ORDER BY
        N.NotaFinal DESC;
END
GO

-- Ejemplo de uso:
EXEC p_ObtenerAlumnosPorRangoNotas 15, 20;

-- 8. Calcular el Promedio de Notas por Carrera
CREATE PROCEDURE p_CalcularPromedioNotasPorCarrera
    @CodCarrera CHAR(3),
    @Semestre VARCHAR(20)
AS
BEGIN
    SELECT
        AVG(N.NotaFinal) AS PromedioNotas
    FROM
        TNotas N
    INNER JOIN
        TAlumno A ON N.CodAlumno = A.CodAlumno
    WHERE
        A.CodCarrera = @CodCarrera AND
        N.Semestre = @Semestre;
END
GO

-- Ejemplo de uso:
EXEC p_CalcularPromedioNotasPorCarrera 'C01', '2010-I';

-- 9. Listar Alumnos con Asignaturas Aprobadas y Desaprobadas
CREATE PROCEDURE p_ListarAlumnosAsignaturasAprobadasDesaprobadas
    @Semestre VARCHAR(20)
AS
BEGIN
    SELECT
        A.CodAlumno,
        A.APaterno,
        A.AMaterno,
        A.Nombres,
        ASG.Asignatura,
        N.NotaFinal,
        CASE
            WHEN N.NotaFinal >= 11 THEN 'Aprobado'
            ELSE 'Desaprobado'
        END AS Estado
    FROM
        TAlumno A
    INNER JOIN
        TNotas N ON A.CodAlumno = N.CodAlumno
    INNER JOIN
        TAsignatura ASG ON N.CodAsignatura = ASG.CodAsignatura
    WHERE
        N.Semestre = @Semestre
    ORDER BY
        A.CodAlumno, ASG.Asignatura;
END
GO

-- Ejemplo de uso:
EXEC p_ListarAlumnosAsignaturasAprobadasDesaprobadas '2010-I';

-- 10. Eliminar Alumno y sus Notas
CREATE PROCEDURE p_EliminarAlumnoConNotas
    @CodAlumno CHAR(5)
AS
BEGIN
    DELETE FROM TNotas
    WHERE CodAlumno = @CodAlumno;
    
    DELETE FROM TAlumno
    WHERE CodAlumno = @CodAlumno;
END
GO

-- Ejemplo de uso:
EXEC p_EliminarAlumnoConNotas 'A0030';