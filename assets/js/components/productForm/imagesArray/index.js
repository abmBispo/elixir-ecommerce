import React from 'react';
import { Formik, FieldArray } from "formik";
import If from '../../templates/If';

function renderImages(images, setFieldValue, formName, fieldName) {
  return images.map((image, index) => (
    <input
      key={index}
      type="file"
      name={`${formName}[${fieldName}][${index}]`}
      onChange={(event) => {
        setFieldValue(`[${fieldName}][${index}]`, event.currentTarget.files[0]);
      }} />
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
                {renderImages(values[values.fieldName], setFieldValue, values.formName, values.fieldName, values.inputType)}
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
