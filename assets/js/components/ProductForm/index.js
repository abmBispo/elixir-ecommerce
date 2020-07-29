import React from 'react';
import { Formik, FieldArray } from "formik";
import If from '../templates/If';

const initialValues = {
  name: '',
  amount: '',
  price: '',
  department: '',
  description: '',
  images: []
};

function onSubmit(values, { setSubmitting }) {
  alert(JSON.stringify(values, null, 2));
  setSubmitting(false);
}

function renderImages(images, arrayHelpers) {
  return images.map((image, index) => (
    <div key={index}>
      <input type="text" name={`images.${index}`} />
      <button type="button" onClick={() => arrayHelpers.remove(index)}>-</button>
      <button type="button" onClick={() => arrayHelpers.insert(index, "")}>+</button>
    </div>
  ))
}

function formContent({ values, errors, touched, handleChange, handleBlur, handleSubmit, isSubmitting }) {
  return (
    <form onSubmit={handleSubmit}>
      <div className='form-row'>
        <div className='form-group col-md-6'>
          <label htmlFor="name">Product name</label>
          <input type="text" name="name" className='form-control' onChange={handleChange} onBlur={handleBlur} value={values.name} />
        </div>
      </div>

      <div className='form-row'>
        <div className='form-group col-md-4'>
          <label htmlFor="name">Amount</label>
          <input type="number" name="amount" className='form-control' onChange={handleChange} onBlur={handleBlur} value={values.amount} />
        </div>
        <div className='form-group col-md-4'>
          <label htmlFor="name">Price</label>
          <input type="number" name="price" className='form-control' onChange={handleChange} onBlur={handleBlur} value={values.price} />
        </div>
        <div className='form-group col-md-4'>
          <label htmlFor="name">Department</label>
          <select id="department" class="form-control">
            <option selected>Eletronics</option>
            <option>...</option>
          </select>
          <input type="number" name="department" className='form-control' onChange={handleChange} onBlur={handleBlur} value={values.department} />
        </div>
      </div>

      Description: <input type="text" name="description" onChange={handleChange} onBlur={handleBlur} value={values.description} />

      <FieldArray name="images"
        render={(arrayHelpers) => (
          <div>
            <If test={values.images.length > 0}>
              {renderImages(values.images, arrayHelpers)}
            </If>
            <If test={!values.images || values.images.length === 0}>
              <button type="button" onClick={() => arrayHelpers.push("")}>Add a Image</button>
            </If>
          </div>
        )}
      />

      <button type="submit" disabled={isSubmitting}>Create</button>
    </form>
  );
}

export default () => (
  <div>
    <Formik initialValues={initialValues} onSubmit={onSubmit}>
      {formContent}
    </Formik>




  </div>
);;
