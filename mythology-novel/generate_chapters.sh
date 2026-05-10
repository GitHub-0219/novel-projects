#!/bin/bash
# 批量生成小说章节的辅助脚本
# 这个脚本会创建章节文件的骨架，具体内容需要手动填充

NOVEL_DIR="/root/.openclaw/workspace/novel-projects/mythology-novel/chapters"

# 中文数字转换函数
num_to_chinese() {
    local num=$1
    local result=""
    
    # 处理百位
    if [ $num -ge 100 ]; then
        local bai=$((num / 100))
        case $bai in
            1) result="一百" ;;
            2) result="二百" ;;
        esac
        num=$((num % 100))
    fi
    
    # 处理十位
    if [ $num -ge 10 ]; then
        local shi=$((num / 10))
        case $shi in
            1) result="${result}十" ;;
            2) result="${result}二十" ;;
            3) result="${result}三十" ;;
            4) result="${result}四十" ;;
            5) result="${result}五十" ;;
            6) result="${result}六十" ;;
            7) result="${result}七十" ;;
            8) result="${result}八十" ;;
            9) result="${result}九十" ;;
        esac
        num=$((num % 10))
    fi
    
    # 处理个位
    if [ $num -gt 0 ]; then
        case $num in
            1) result="${result}一" ;;
            2) result="${result}二" ;;
            3) result="${result}三" ;;
            4) result="${result}四" ;;
            5) result="${result}五" ;;
            6) result="${result}六" ;;
            7) result="${result}七" ;;
            8) result="${result}八" ;;
            9) result="${result}九" ;;
        esac
    fi
    
    echo "$result"
}

# 生成章节文件
generate_chapter() {
    local num=$1
    local title=$2
    local content=$3
    local suspense=$4
    
    local padded_num=$(printf "%03d" $num)
    local chinese_num=$(num_to_chinese $num)
    local filename="${padded_num}-第${chinese_num}章.md"
    
    cat > "${NOVEL_DIR}/${filename}" << EOF
# 第${chinese_num}章 ${title}

${content}

---

*（本章完）*

*${suspense}*
EOF
    
    echo "Generated: ${filename}"
}

# 示例调用
# generate_chapter 41 "章节标题" "章节内容" "章末悬念提示"
