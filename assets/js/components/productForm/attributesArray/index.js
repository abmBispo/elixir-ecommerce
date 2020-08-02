import React from 'react';
import { Formik, FieldArray } from "formik";
import If from '../../templates/If';

function renderFields(fields, setFieldValue, formName, fieldName) {
  return fields.map((_, index) => (
    <>
      <input
        key={index}
        type="text"
        name={`${formName}[${fieldName}][${index}][title]`}
        onChange={(event) => {
          setFieldValue(`[${fieldName}][${index}][title]`, event.target.value);
        }} />
      <input
        key={1000 - index}
        type="text"
        name={`${formName}[${fieldName}][${index}][description]`}
        onChange={(event) => {
          setFieldValue(`[${fieldName}][${index}][description]`, event.target.value);
        }} />
    </>
  ));
}

function formContent({ values, setFieldValue }) {
  return (
    <div className='form-row'>
      <div className='form-group col-12'>
        <FieldArray
          name={values.fieldName}
          render={(arrayHelpers) => (
            <>
              <If test={values[values.fieldName].length > 0}>
                {renderFields(values[values.fieldName], setFieldValue, values.formName, values.fieldName, values.inputType)}
              </If>
              <button type="button" onClick={() => arrayHelpers.push("")}>+</button>
            </>
          )}
        />
      </div>
    </div>
  );
}

export default (props) => {
  const { formName, fieldName, inputType } = props;
  const initialValues = { formName: formName, fieldName: fieldName, inputType: inputType };
  initialValues[fieldName] = [];

  return (
    <Formik initialValues={initialValues}>
      {formContent}
    </Formik>
  );
};
