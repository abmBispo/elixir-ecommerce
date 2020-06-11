defmodule ElixirEcommerce.DepartmentTest do
  use ElixirEcommerce.DataCase
  alias ElixirEcommerce.Department

  @valid_attrs %{name: "Sports"}
  @update_attrs %{name: "Eletronics"}
  @invalid_attrs %{name: ""}

  def department_fixture(attrs \\ %{}) do
    {:ok, department} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Department.create()
    department
  end

  describe "departments" do
    test "Should create department with valid params" do
      assert {:ok, department} = Department.create(@valid_attrs)
      assert department.name == "Sports"
    end

    test "Should not create department without name" do
      assert {:error, %Ecto.Changeset{}} = Department.create(@invalid_attrs)
    end

    test "Should update department with valid params" do
      department = department_fixture(@valid_attrs)
      assert {:ok, department} = Department.update(department, @update_attrs)
      assert department.name == "Eletronics"
    end

    test "Should not update department with valid params" do
      department = department_fixture(@valid_attrs)
      assert {:error, %Ecto.Changeset{}} = Department.update(department, @invalid_attrs)
    end
  end
end
