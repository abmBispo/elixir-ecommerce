import React from 'react';
import { Formik, FieldArray } from "formik";
import If from '../../templates/If';

function renderFields(fields, setFieldValue, formName, fieldName) {
  return fields.map((_, index) => (
    <div className="form-row">
      <div className="form-group col-6">
        <input
          key={index}
          className="form-control"
          type="text"
          name={`${formName}[${fieldName}][${index}][title]`}
          onChange={(event) => {
            setFieldValue(`[${fieldName}][${index}][title]`, event.target.value);
          }} />
      </div>
      <div className="form-group col-6">
        <input
          key={1000 - index}
          className="form-control"
          type="text"
          name={`${formName}[${fieldName}][${index}][description]`}
          onChange={(event) => {
            setFieldValue(`[${fieldName}][${index}][description]`, event.target.value);
          }} />
      </div>
    </div>
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

              <div className="form-row">
                <div className="form-group col-6">
                  <h4>Title</h4>
                </div>
                <div className="form-group col-6">
                  <h4>Description</h4>
                </div>
              </div>

              <If test={values[values.fieldName].length > 0}>
                {renderFields(values[values.fieldName], setFieldValue, values.formName, values.fieldName, values.inputType)}
              </If>
              <button type="button" className="btn btn-outline-primary" onClick={() => arrayHelpers.push("")}>Add description</button>
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
  initialValues[fieldName] = [{}];

  return (
    <Formik initialValues={initialValues}>
      {formContent}
    </Formik>
  );
};
