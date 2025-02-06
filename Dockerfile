# ใช้ Node.js base image
FROM node:18

WORKDIR /app

# คัดลอกไฟล์ที่จำเป็น และติดตั้ง dependencies
COPY package.json package-lock.json ./
RUN npm install --production

# คัดลอกโค้ดทั้งหมด
COPY . .

# สร้าง Next.js แอป
RUN npm run build

# เปิดพอร์ต 3000 (หรือเปลี่ยนตามต้องการ)
EXPOSE 3000

# รันแอป
CMD ["npm", "run", "start"]
