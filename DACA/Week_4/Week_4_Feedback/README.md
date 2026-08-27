# 💬 Week 4 – Feedback & Reflections

[![DACA](https://img.shields.io/badge/DACA-Week_4-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![MATLAB](https://img.shields.io/badge/MATLAB-Experience-0076A8?style=for-the-badge&logo=mathworks&logoColor=white)](https://www.mathworks.com/)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This document captures my personal reflections on Week 4 of the DACA programme. It describes how my background as a **PhD physics student** influenced my approach to this week's SQL aggregation tasks, the challenges I faced, and the lessons I learned about balancing analytical depth with practical delivery.

---

## 🧠 My Background & Tool Choice

### Physics PhD Background

I come from a **physics research background**, where I have spent over **8 years** working as a PhD student in physics at the university. This background has fundamentally shaped how I approach problems:

- **Deep analysis is natural** – physics research requires rigorous, systematic investigation of every detail
- **Pattern recognition is second nature** – physics trains you to see patterns in complex data
- **Validation is ingrained** – in physics, you always cross-check your results with multiple methods

**The Challenge:** This background, while powerful, has often led me to **over-analyse** tasks in the DACA programme. I tend to go beyond what's required, exploring edge cases, alternative approaches, and deeper patterns that weren't necessarily part of the assignment.

### Why MATLAB Instead of Python

During Week 4, I needed to create visualisations to better understand the sales trends I had aggregated. Rather than using Python (which I was still learning), I chose **MATLAB** – a tool I had been using professionally for **8 years** through my physics research.

| Tool | My Experience | Why I Chose It |
| :--- | :--- | :--- |
| **MATLAB** | 8 years of professional use (PhD physics) | I knew it well and could create high-quality visualisations quickly |
| **Python (matplotlib/plotly)** | Limited experience | Still learning; would have slowed me down |

**The Decision:** Using MATLAB allowed me to focus on **what** I was analysing (the data patterns) rather than **how** to visualise it (the tool syntax). This is a practical, professional approach: use the right tool for the job, especially when time is limited.

---

## 🔄 Evolution from Week 3 to Week 4

### Week 3: Connection (JOINs)

| Aspect | Week 3 Approach |
| :--- | :--- |
| **Focus** | Connecting data across tables |
| **Key Techniques** | `INNER JOIN`, `LEFT JOIN`, multi-table JOINs |
| **Complexity** | Moderate |
| **Output** | Joined datasets for analysis |

### Week 4: Aggregation (Summarisation)

| Aspect | Week 4 Approach |
| :--- | :--- |
| **Focus** | Summarising data into business KPIs |
| **Key Techniques** | `GROUP BY`, `HAVING`, CTEs, window functions |
| **Complexity** | High |
| **Output** | Aggregated reports and visualisations |

---

## 🧠 What Changed

### 1. From Connection to Summarisation

**Week 3:** I learned how to connect tables – bringing customer names, product categories, and location data into sales records.

**Week 4:** I learned how to summarise that connected data – turning 10,118 sales rows into 12 monthly summary rows that a CEO can understand.

**Key Learning:** Data connection is about **finding the pieces**; aggregation is about **telling the story**.

---

### 2. The Over-Analysis Tendency

My physics background caused me to:

| Behaviour | Example |
| :--- | :--- |
| **Explore edge cases** | I spent extra time investigating the 2025 data drop, trying to understand why it occurred |
| **Cross-check multiple ways** | I validated my aggregation results against raw data, Excel calculations, and visualisations |
| **Look for patterns** | I noticed seasonal trends (summer peaks, year-end spikes) that went beyond the basic requirements |
| **Question assumptions** | I questioned the "50% growth" estimate and corrected it to ~19% after validation |

**What I Learned:**

> *"In physics, over-analysis is a strength – you can't publish a paper with unverified results. In business analytics, over-analysis can be a weakness – stakeholders need answers, not academic papers. The key is finding the right balance: validate enough to be confident, but deliver before the deadline."*

---

### 3. MATLAB Visualisation – Practical Over Perfection

The 12 MATLAB visualisations I created revealed a **critical data gap**:

| Visualisation | Key Insight |
| :--- | :--- |
| **Linear Y-axis** | The 2023–2024 data (high values) compressed the 2025–2026 data (low values) into an unreadable line |
| **Logarithmic Y-axis** | Both high and low values became visible, clearly showing the sudden drop at the start of 2025 |

**Key Learning:** Logarithmic scaling is not "cheating" – it's a legitimate visualisation technique that reveals patterns that linear scaling hides. This is a lesson I carried over from physics, where log scales are used constantly to visualise data across orders of magnitude.

---

## 🔍 Key Challenges

### 1. Balancing Depth with Delivery

**The Physics Approach:** Explore every edge case, validate from multiple angles, understand the "why" behind every pattern.

**The Business Approach:** Deliver actionable insights on time, even if some details are still being investigated.

**My Struggle:** I consistently leaned toward the physics approach – I wanted to understand **why** the 2025 data dropped, **why** the initial growth estimate was wrong, and **what** the seasonal patterns meant. This took extra time but ultimately produced more reliable results.

**Resolution:** I learned to:
- Validate my numbers thoroughly
- Document my assumptions and limitations
- Present findings honestly, including what I didn't know
- Deliver on time, with a plan for follow-up investigation

---

### 2. The MATLAB vs Python Decision

| Consideration | My Choice |
| :--- | :--- |
| **MATLAB** | 8 years of experience; could create high-quality visualisations quickly |
| **Python** | Still learning; would have taken longer to achieve the same quality |

**Why This Was the Right Choice:**

- **Time was limited** – creating the visualisations quickly was more important than using the "right" tool
- **Quality mattered** – I needed clear, professional visualisations to understand the data
- **Learning happens gradually** – I'll learn Python visualisation in future weeks; using MATLAB didn't prevent that

**Key Learning:** Don't wait until you've mastered the "perfect" tool. Use what you know, get the job done, and learn the new tool later.

---

## 💡 What I Learned

### Technical Skills

| Skill | Before (Week 3) | After (Week 4) |
| :--- | :--- | :--- |
| **GROUP BY** | Basic understanding | Confident with multiple dimensions |
| **HAVING** | Knew it existed | Used effectively for filtering groups |
| **CTEs** | Some exposure | Built complex, parameterised CTE chains |
| **Window Functions** | None | Used `LAG()` for trend analysis |
| **Data Validation** | Minimal | Cross-checked totals against raw data |

### Professional Skills

| Skill | Before | After |
| :--- | :--- | :--- |
| **Tool Selection** | Often chose "learning" over "practical" | Chose MATLAB based on experience |
| **Over-Analysis** | Default approach | Learning to balance depth with delivery |
| **Honest Reporting** | Sometimes hid limitations | Documented assumptions and gaps explicitly |
| **Visualisation** | Basic | Created 12 professional visualisations in MATLAB |

---

## 🎯 Key Takeaways

1. **Use what you know** – MATLAB was the right choice for this week's visualisations because I know it well. I can learn Python visualisation later.

2. **Over-analysis is both a strength and a weakness** – my physics background led me to explore deeply and validate thoroughly, which produced accurate results. But it also took extra time. The key is finding the right balance.

3. **Log scales reveal patterns** – the 2025 data drop was invisible on linear scales but immediately obvious on log scales. This is a lesson from physics that applied perfectly to business data.

4. **Validate your numbers** – the initial "50% growth" estimate was wrong. Validation showed ~19%. Always cross-check your aggregated totals.

5. **Don't hide limitations** – the 2025 data is incomplete, not a business collapse. Being honest about data limitations builds trust with stakeholders.

6. **Document your assumptions** – every analysis has assumptions. Documenting them helps others understand your work.

---

## 📝 Final Reflection

> *"My physics background has been both a blessing and a challenge in this programme. The rigorous, analytical thinking that I developed over 8 years of research helps me dig deep into data and find patterns that others might miss. But it also makes me prone to over-analysis – spending too much time on details that don't matter to the business question. Week 4 was a turning point: I learned that I can use my analytical skills to produce high-quality work, but I need to be conscious of when to stop digging and start delivering."*

---

## 🔗 Related Files

- [Week 4 Code Folder](../Week_4_Code/)
- [Week 4 Results Folder](../Week_4_Results/)
- [Week 4 Main README](../README.md)
- [Week 4 Pictures README](../Week_4_Results/Week_4_Pictures/README.md)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
