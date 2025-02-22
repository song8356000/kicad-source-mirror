%ignore EDA_SHAPE::getCenter;

%{
#include <geometry/eda_angle.h>
#include <eda_shape.h>
#include <pcb_shape.h>
%}
%include geometry/eda_angle.h
%include eda_shape.h
%include pcb_shape.h

%extend PCB_SHAPE
{
    double GetArcAngleStart()
    {
        EDA_ANGLE startAngle;
        EDA_ANGLE endAngle;
        $self->CalcArcAngles( startAngle, endAngle );
        return startAngle.AsTenthsOfADegree();
    }

    %pythoncode
    %{
    def GetShapeStr(self):
        return self.ShowShape(self.GetShape())
    %}
}

/* Only for compatibility with old python scripts: */
const int S_SEGMENT = (const int)SHAPE_T::SEGMENT;
const int S_RECT = (const int)SHAPE_T::RECT;
const int S_ARC = (const int)SHAPE_T::ARC;
const int S_CIRCLE = (const int)SHAPE_T::CIRCLE;
const int S_POLYGON = (const int)SHAPE_T::POLY;
const int S_CURVE = (const int)SHAPE_T::BEZIER;

%{
/* for compatibility with old python scripts: */
const int S_SEGMENT = (const int)SHAPE_T::SEGMENT;
const int S_RECT = (const int)SHAPE_T::RECT;
const int S_ARC = (const int)SHAPE_T::ARC;
const int S_CIRCLE = (const int)SHAPE_T::CIRCLE;
const int S_POLYGON = (const int)SHAPE_T::POLY;
const int S_CURVE = (const int)SHAPE_T::BEZIER;
%}
