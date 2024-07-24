#!/bin/bash

# Yêu cầu người dùng nhập commit đầu tiên
read -p "Nhập commit đầu tiên (commit1): " commit1
# Yêu cầu người dùng nhập commit thứ hai
read -p "Nhập commit thứ hai (commit2): " commit2
# Yêu cầu người dùng nhập thư mục đích
read -p "Nhập thư mục đích để lưu các file thay đổi (output_dir): " output_dir

# Tạo thư mục đích nếu nó chưa tồn tại
mkdir -p ~/export-code/$output_dir

# Lấy danh sách các file thay đổi và thêm mới giữa hai commit
files=$(git diff --name-status $commit1 $commit2 | grep -E '^[AM]' | awk '{print $2}')

# Duyệt qua từng file và sao chép nó vào thư mục đích
for file in $files; do
    # Tạo thư mục con nếu cần thiết
    mkdir -p ~/export-code/$output_dir/$(dirname $file)
    # Sao chép file vào thư mục đích
    cp $file ~/export-code/$output_dir/$file
done

echo "Đã xuất các file thay đổi và thêm mới vào thư mục ~/export-code/$output_dir"
