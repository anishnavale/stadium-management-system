PROC_ADD_NEW_SECTION(NULL, NULL, NULL, NULL, NULL, NULL);
PROC_ADD_NEW_SECTION(NULL, 'G1', 'Park Drive', 'Boston', 'MA', '02215');
PROC_ADD_NEW_SECTION('North', 'G1', 'Park Drive', 'Boston', 'MA', '02215');
PROC_ADD_NEW_SECTION('North', 'G1', 'Park Drive', 'Boston', 'MA', '02215');
PROC_ADD_NEW_SECTION('East', 'G1', 'Park Drive', 'Boston', 'MA', '02215');
PROC_ADD_NEW_SECTION('East', 'G2', 'Park Drive', 'Boston', 'MA', '02215');
PROC_ADD_NEW_SECTION('West', 'G3', 'Park Drive', 'Boston', 'MA', '02215');
PROC_ADD_NEW_SECTION('South', 'G4', 'Park Drive', 'Boston', 'MA', '02215');


PROC_UPDATE_SECTION(NULL, NULL, NULL, NULL, NULL, NULL);
PROC_UPDATE_SECTION(NULL, 'G1', 'Park Drive', 'Boston', 'MA', '02215');
PROC_UPDATE_SECTION(2, 'G5', 'Park Drive', 'Boston', 'MA', NULL);
PROC_UPDATE_SECTION(1, 'G5', 'Park Drive', 'Boston', 'MA', '02215');
PROC_UPDATE_SECTION(2, 'G2', 'Boylston', 'Boston', 'MA', '02215');
PROC_UPDATE_SECTION(2, 'G5', 'Park Drive', 'Boston', 'MA', '02215');
PROC_UPDATE_SECTION(10, 'G5', 'Park Drive', 'Boston', 'MA', '02215');