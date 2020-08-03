import React from 'react';
import { Formik, FieldArray } from "formik";
import If from '../../templates/If';
import Thumb from './Thumb';

function formContent({ values, setFieldValue }) {
  return (
    <div className='form-row'>
      <div className='form-group col-12'>
        <FieldArray
          name={values.fieldName}
          render={(arrayHelpers) => (
            <>
              <If test={values[values.fieldName].length > 0}>
                {
                  values[values.fieldName].map((value, index) => {
                    return (
                      <div key={1000 - index}>
                        <input
                          key={index}
                          type="file"
                          name={`${values.formName}[${values.fieldName}][${index}]`}
                          onChange={(event) => setFieldValue(`${values.fieldName}[${index}].file`, event.currentTarget.files[0])} />
                        <Thumb key={2000 - index} file={values[values.fieldName][index].file} />
                      </div>
                    )
                  })
                }
              </If>
              <br />
              <button type="button" onClick={() => arrayHelpers.push({ file: null })} className="btn btn-outline-primary">
                Add image to product
              </button>
            </>
          )}
        />
      </div>
    </div>
  );
}

export default (props) => {
  const { formName, fieldName } = props;
  const initialValues = { formName: formName, fieldName: fieldName };
  initialValues[fieldName] = [];

  return (
    <Formik initialValues={initialValues}>
      {formContent}
    </Formik>
  );
};
